using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class DatabaseInitializer : DropCreateDatabaseAlways<UserOperationsContext>
    {

        protected override void Seed(UserOperationsContext context)
        {
            context.ActivityTypes.Add(new ActivityType
            {
                ActivityTypeId = 1,
                ActivityTypeName = "Generico",
                CreationDate = DateTime.Now,
                Description = "Tipo Generico"
            });
            context.ProjectTypes.Add(new ProjectType
            {
                ProjectTypeId = 1,
                ProjectTypeName = "Generico",
                CreationDate = DateTime.Now,
                Description = "Tipo Generico"
            });
        }

        
    }
}