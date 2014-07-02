namespace VALE.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddManyToManyRelation : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.UserDatas", "Group_GroupId", "dbo.Groups");
            DropIndex("dbo.UserDatas", new[] { "Group_GroupId" });
            CreateTable(
                "dbo.GroupsUsers",
                c => new
                    {
                        GroupId = c.Int(nullable: false),
                        UserDataId = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.GroupId, t.UserDataId })
                .ForeignKey("dbo.Groups", t => t.GroupId, cascadeDelete: true)
                .ForeignKey("dbo.UserDatas", t => t.UserDataId, cascadeDelete: true)
                .Index(t => t.GroupId)
                .Index(t => t.UserDataId);
            
            DropColumn("dbo.UserDatas", "Group_GroupId");
        }
        
        public override void Down()
        {
            AddColumn("dbo.UserDatas", "Group_GroupId", c => c.Int());
            DropForeignKey("dbo.GroupsUsers", "UserDataId", "dbo.UserDatas");
            DropForeignKey("dbo.GroupsUsers", "GroupId", "dbo.Groups");
            DropIndex("dbo.GroupsUsers", new[] { "UserDataId" });
            DropIndex("dbo.GroupsUsers", new[] { "GroupId" });
            DropTable("dbo.GroupsUsers");
            CreateIndex("dbo.UserDatas", "Group_GroupId");
            AddForeignKey("dbo.UserDatas", "Group_GroupId", "dbo.Groups", "GroupId");
        }
    }
}
