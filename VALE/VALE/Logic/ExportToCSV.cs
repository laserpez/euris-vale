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
        ActivityActions activityActions = new ActivityActions();
        public StringBuilder ExportActivities(List<Activity> activities, string userName)
        {
            StringBuilder strbldr = new StringBuilder();
            //separting header columns text with comma operator
            strbldr.Append("Id;Nome Attività;Data Inizio;Data Fine;Ore Di Lavoro;Stato;Tipo");
            //appending new line for gridview header row
            strbldr.Append("\n");
            foreach (var activity in activities)
            {
                strbldr.Append(activity.ActivityId.ToString() + ';');
                strbldr.Append(activity.ActivityName + ';');

                if (activity.StartDate.HasValue)
                    strbldr.Append(activity.StartDate.Value.ToShortDateString() + ';');
                else
                    strbldr.Append("Non definito;");
                if (activity.ExpireDate.HasValue)
                    strbldr.Append(activity.ExpireDate.Value.ToShortDateString() + ';');
                else
                    strbldr.Append("Non definito;");
                strbldr.Append(activityActions.GetHoursWorked(userName, activity.ActivityId).ToString() + ';');
                strbldr.Append(activityActions.GetStatus(activity) + ';');
                strbldr.Append(activity.Type + ';');
                strbldr.Append("\n");
            }
            return strbldr;
        }

        public void Dispose()
        {

        }
    }
}