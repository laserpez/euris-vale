﻿using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration.Conventions;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class UserOperationsContext :DbContext
    {
        public UserOperationsContext() : base("VALEData") { }

        public DbSet<Event> Events { get; set; }
        public DbSet<Activity> Activities { get; set; }
        public DbSet<Project> Projects { get; set; }
        public DbSet<UserData> UsersData { get; set; }
        public DbSet<ActivityReport> Reports { get; set; }
        public DbSet<Intervention> Interventions { get; set; }
        public DbSet<Comment> Comments { get; set; }
        public DbSet<BlogArticle> BlogArticles { get; set; }
        public DbSet<BlogComment> BlogComments { get; set; }
        public DbSet<BODReport> BODReports { get; set; }
        public DbSet<AttachedFile> AttachedFiles { get; set; }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Event>().HasOptional(e => e.RelatedProject).WithMany(p => p.Events).WillCascadeOnDelete();
            
            modelBuilder.Entity<Event>()
                .HasMany(u => u.RegisteredUsers)
                .WithMany(e => e.AttendingEvents)
                .Map(m =>
                    {
                        m.MapLeftKey("EventId");
                        m.MapRightKey("UserDataId");
                        m.ToTable("EventsUsers");
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

        }
    }
}