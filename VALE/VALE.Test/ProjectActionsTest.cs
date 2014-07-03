using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VALE.Logic;
using VALE.Models;

namespace VALE.Test
{
    [TestFixture]
    class ProjectActionsTest
    {
        private ProjectActions projectActions;

        [SetUp]
        public void SetUp()
        {
            projectActions = new ProjectActions();
        }

        [TearDown]
        public void TearDown()
        {
            
        }

        [Test]
        public void should_get_filteredData_withEmptyDisctionary()
        {
            List<Project> projs = new List<Project>();
            var dictionary = new Dictionary<string, string>();

            projs.Add(new Project { ProjectName = "primo progetto" });
            projs.Add(new Project { ProjectName = "secondo progetto" });
            projs.Add(new Project { ProjectName = "terzo progetto" });

            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 3);

        }

        [Test]
        public void should_get_filteredData_wrongValue()
        {
            List<Project> projs = new List<Project>();
            var dictionary = new Dictionary<string, string>();

            dictionary.Add("Name", "qwerty");

            projs.Add(new Project { ProjectName = "primo progetto" });
            projs.Add(new Project { ProjectName = "secondo progetto" });
            projs.Add(new Project { ProjectName = "terzo progetto" });

            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 0);

        }

        [Test]
        public void should_get_filteredData_byName()
        {
            List<Project> projs = new List<Project>();
            var dictionary = new Dictionary<string, string>();
            var dictionary1 = new Dictionary<string, string>();

            projs.Add(new Project { ProjectName = "primo progetto" });
            projs.Add(new Project { ProjectName = "secondo progetto" });
            projs.Add(new Project { ProjectName = "terzo progetto" });

            dictionary.Add("Name", "primo");
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 1 &&
                          projectActions.GetFilteredData<Project>(dictionary, projs).FirstOrDefault().ProjectName == "primo progetto");

            dictionary1.Add("Name", "progetto");
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary1, projs).Count == 3);
            foreach (var elem in projectActions.GetFilteredData<Project>(dictionary1, projs))
                Assert.IsTrue(elem.ProjectName.Contains("progetto"));

        }

        [Test]
        public void should_get_filteredData_byDescription()
        {
            List<Project> projs = new List<Project>();
            var dictionary = new Dictionary<string, string>();
            var dictionary1 = new Dictionary<string, string>();

            projs.Add(new Project { Description = "primo progetto" });
            projs.Add(new Project { Description = "secondo progetto" });
            projs.Add(new Project { Description = "terzo progetto" });

            dictionary.Add("Description", "primo");
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 1 &&
                          projectActions.GetFilteredData<Project>(dictionary, projs).FirstOrDefault().Description == "primo progetto");

            dictionary1.Add("Description", "progetto");
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary1, projs).Count == 3);
            foreach (var elem in projectActions.GetFilteredData<Project>(dictionary1, projs))
                Assert.IsTrue(elem.Description.Contains("progetto"));

        }

        [Test]
        public void should_get_filteredData_byCreationDate()
        {

            List<Project> projs = new List<Project>();
            var dictionary = new Dictionary<string, string>();

            projs.Add(new Project { CreationDate = new DateTime(2000, 1, 1) });
            projs.Add(new Project { CreationDate  = new DateTime(2000, 2, 2) });
            projs.Add(new Project { CreationDate = new DateTime(2000, 3, 3) });

            dictionary.Add("CreationDate", new DateTime(2000, 1, 1).ToShortDateString());

            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 1 &&
                          projectActions.GetFilteredData<Project>(dictionary, projs).FirstOrDefault().CreationDate == new DateTime(2000, 1, 1));

            projs.Add(new Project { CreationDate = new DateTime(2000, 1, 1) });
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 2);
            foreach (var elem in projectActions.GetFilteredData<Project>(dictionary, projs))
                Assert.IsTrue(elem.CreationDate.Year == 2000);

        }

        [Test]
        public void should_get_filteredData_byLastModifiedDate()
        {

            List<Project> projs = new List<Project>();
            var dictionary = new Dictionary<string, string>();

            projs.Add(new Project { LastModified = new DateTime(2000, 1, 1) });
            projs.Add(new Project { LastModified = new DateTime(2000, 2, 2) });
            projs.Add(new Project { LastModified = new DateTime(2000, 3, 3) });

            dictionary.Add("LastModifiedDate", new DateTime(2000, 1, 1).ToShortDateString());

            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 1 &&
                          projectActions.GetFilteredData<Project>(dictionary, projs).FirstOrDefault().LastModified == new DateTime(2000, 1, 1));

            projs.Add(new Project { LastModified = new DateTime(2000, 1, 1) });
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 2);
            foreach (var elem in projectActions.GetFilteredData<Project>(dictionary, projs))
                Assert.IsTrue(elem.LastModified.Year == 2000);


        }

        [Test]
        public void should_get_filteredData_byProjectStatus()
        {
            List<Project> projs = new List<Project>();
            var dictionary = new Dictionary<string, string>();
            var dictionary1 = new Dictionary<string, string>();

            projs.Add(new Project { Status = "Aperto" });
            projs.Add(new Project { Status = "Cancellato" });
            projs.Add(new Project { Status = "Sospeso" });

            dictionary.Add("ProjectStatus", "Aperto");
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 1 &&
                          projectActions.GetFilteredData<Project>(dictionary, projs).FirstOrDefault().Status == "Aperto");

            dictionary1.Add("ProjectStatus", "Sospeso");
            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary1, projs).Count == 1 &&
                          projectActions.GetFilteredData<Project>(dictionary1, projs).FirstOrDefault().Status == "Sospeso");

        }

        [Test]
        public void shoul_get_filter_concat()
        {
            List<Project> projs = new List<Project>();
            projs.Add(new Project { ProjectName = "primo progetto", 
                                    Description = "descrizione primo progetto", 
                                    OrganizerUserName = "Primo", 
                                    ProjectId = 1, 
                                    Status= "Aperto" });
            projs.Add(new Project { ProjectName = "secondo progetto" ,
                                    Description = "descrizione secondo progetto", 
                                    OrganizerUserName = "Secondo", 
                                    ProjectId = 2, 
                                    Status= "Aperto" });
            projs.Add(new Project { ProjectName = "terzo progetto" ,
                                    Description = "descrizione terzo progetto",  
                                    OrganizerUserName = "Terzo", 
                                    ProjectId = 3, 
                                    Status= "Aperto" });
            projs.Add(new Project { ProjectName = "quarto progetto" ,
                                    Description = "descrizione quarto progetto", 
                                    OrganizerUserName = "Quarto", 
                                    ProjectId = 4, 
                                    Status= "Aperto" });

            var dictionary = new Dictionary<string, string>();
            dictionary.Add("Name", "primo");
            dictionary.Add("Description", "primo");
            dictionary.Add("ProjectStatus", "Aperto");

            Assert.IsTrue(projectActions.GetFilteredData<Project>(dictionary, projs).Count == 1);
        }
    }
}
