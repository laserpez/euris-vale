using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public class ExportToCSV : IDisposable
    {
        public StringBuilder ExportActivities(List<string> usersNames)
        {
            StringBuilder strbldr = new StringBuilder();
            List<Activity> activities;

            using (var activityActions = new ActivityActions())
            {
                //separting header columns text with comma operator
                strbldr.Append("Utente;Id;Nome Attività;Data Inizio;Data Fine;Ore Di Lavoro;Stato");
                //appending new line for gridview header row
                strbldr.Append("\n");
                foreach (var userName in usersNames)
                {
                    activities = activityActions.GetActivities(userName);
                    foreach (var activity in activities)
                    {
                        strbldr.Append(userName + ';');
                        strbldr.Append(activity.ActivityId.ToString() + ';');
                        strbldr.Append(activity.ActivityName + ';');
                        strbldr.Append(activity.StartDate.Value.ToShortDateString() + ';');
                        if (activity.ExpireDate.HasValue)
                            strbldr.Append(activity.ExpireDate.Value.ToShortDateString() + ';');
                        else
                            strbldr.Append("Non definito;");
                        strbldr.Append(activityActions.GetHoursWorked(userName, activity.ActivityId).ToString() + ';');
                        strbldr.Append(activity.Status + ';');
                        strbldr.Append("\n");
                    }
                }
            }
           
            return strbldr;
        }

        public void Dispose()
        {

        }
    }
}