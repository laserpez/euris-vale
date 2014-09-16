using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Web;
using VALE.Logic;

namespace VALE.Models
{
    public class UserOperationsContext :DbContext
    {
        public UserOperationsContext() : base("VALEData") { }
        public DbSet<Event> Events { get; set; }
        public DbSet<Activity> Activities { get; set; }
        public DbSet<Project> Projects { get; set; }
        public DbSet<UserData> UserDatas { get; set; }
        public DbSet<ActivityReport> Reports { get; set; }
        public DbSet<Intervention> Interventions { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<BlogArticle> BlogArticles { get; set; }
        public DbSet<BlogComment> BlogComments { get; set; }
        public DbSet<BODReport> BODReports { get; set; }
        public DbSet<AttachedFile> AttachedFiles { get; set; }
        public DbSet<ValeFile> VALEFiles { get; set; }
        public DbSet<UserFile> UserFiles { get; set; }
        public DbSet<Group> Groups { get; set; }
        public DbSet<LogEntry> LogEntries { get; set; }
        public DbSet<LogEntryEmail> LogEntriesEmail { get; set; }
        public DbSet<MailQueue> MailQueues { get; set; }
        public DbSet<ActivityType> ActivityTypes { get; set; }
        public DbSet<ProjectType> ProjectTypes { get; set; }
        public DbSet<PartnerType> PartnerTypes { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Event>().HasOptional(e => e.RelatedProject).WithMany(p => p.Events).WillCascadeOnDelete();

            modelBuilder.Entity<AttachedFile>().HasOptional(f => f.RelatedProject).WithMany(p => p.AttachedFiles).WillCascadeOnDelete();

            // TODO Controllare la cancellazione a cascata dagli eventi
            //modelBuilder.Entity<AttachedFile>().HasOptional(f => f.RelatedEvent).WithMany(ev => ev.AttachedFiles).WillCascadeOnDelete();
            
            modelBuilder.Entity<Event>()
                .HasMany(u => u.RegisteredUsers)
                .WithMany(e => e.AttendingEvents)
                .Map(m =>
                    {
                        m.MapLeftKey("EventId");
                        m.MapRightKey("UserDataId");
                        m.ToTable("EventsUsers");
                    });

            modelBuilder.Entity<Event>()
                .HasMany(e => e.PendingUsers)
                .WithMany(u => u.PendingEvents)
                .Map(m =>
                {
                    m.MapLeftKey("EventId");
                    m.MapRightKey("UserDataId");
                    m.ToTable("PendingEventsUsers");
                });

            modelBuilder.Entity<Project>()
                .HasMany(u => u.InvolvedUsers)
                .WithMany(e => e.AttendingProjects)
                .Map(m =>
                {
                    m.MapLeftKey("ProjectId");
                    m.MapRightKey("UserDataId");
                    m.ToTable("ProjectsUsers");
                });

            modelBuilder.Entity<Activity>().HasOptional(a => a.RelatedProject).WithMany(p => p.Activities).WillCascadeOnDelete();
            modelBuilder.Entity<Activity>()
                .HasMany(a => a.PendingUsers)
                .WithMany(u => u.PendingActivity)
                .Map(m =>
                {
                    m.MapLeftKey("ActivityId");
                    m.MapRightKey("UserDataId");
                    m.ToTable("PendingActivitiesUsers");
                });

            modelBuilder.Entity<Activity>()
               .HasMany(u => u.RegisteredUsers)
               .WithMany(e => e.AttendingActivities)
               .Map(m =>
               {
                   m.MapLeftKey("ActivityId");
                   m.MapRightKey("UserDataId");
                   m.ToTable("ActivitiesUsers");
               });

            modelBuilder.Entity<Group>()
                .HasMany(g => g.Users)
                .WithMany(u => u.JoinedGroups)
                .Map(m =>
                {
                    m.MapLeftKey("GroupId");
                    m.MapRightKey("UserDataId");
                    m.ToTable("GroupsUsers");
                });

           

        }
    }
}