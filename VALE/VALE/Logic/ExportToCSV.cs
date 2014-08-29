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
                    strbldr.Append(";");
                if (activity.ExpireDate.HasValue)
                    strbldr.Append(activity.ExpireDate.Value.ToShortDateString() + ';');
                else
                    strbldr.Append(";");
                strbldr.Append(activityActions.GetHoursWorked(userName, activity.ActivityId).ToString() + ';');
                strbldr.Append(activityActions.GetStatus(activity) + ';');
                strbldr.Append(activity.Type + ';');
                strbldr.Append("\n");
            }
            return strbldr;
        }

        public StringBuilder ExportSummaryInterventions(List<SummaryIntervention> summaryInterventions)
        {
            StringBuilder strbldr = new StringBuilder();
            //separting header columns text with comma operator
            strbldr.Append("Progetto;Tipo Progetto;Progetto Publico;Progetto Padre;Nome Attività;Tipo Attività;Descrizione;Ore Di Lavoro;Compiuta da;In Data");
            //appending new line for gridview header row
            strbldr.Append("\n");
            foreach (var summaryIntervention in summaryInterventions)
            {
                strbldr.Append(summaryIntervention.ProjectName + ';');
                strbldr.Append(summaryIntervention.ProjectType + ';');
                strbldr.Append(summaryIntervention.ProjectPublic + ';');
                strbldr.Append(summaryIntervention.RelatedProjectName + ';');
                strbldr.Append(summaryIntervention.ActivityName + ';');
                strbldr.Append(summaryIntervention.ActivityType + ';');
                strbldr.Append(summaryIntervention.ActivityDescription + ';');
                strbldr.Append(summaryIntervention.HoursWorked + " ;");
                strbldr.Append(summaryIntervention.WorkerUserName + ';');
                strbldr.Append(summaryIntervention.Date.ToShortDateString() + ';');
                strbldr.Append("\n");
            }
            return strbldr;
        }

        public StringBuilder ExportLogEntryEmail(List<LogEntryEmail> logEntryEmails)
        {
            ILoggerEmail logger = LogFactoryEmail.GetCurrentLoggerEmail();

            StringBuilder strbldr = new StringBuilder();
            //separting header columns text with comma operator
            strbldr.Append("Data;Stato ricezione;Destinatario;Modulo;Oggetto;Corpo del  messaggio;Messaggi di errore");
            //appending new line for gridview header row
            strbldr.Append("\n");
            foreach (var logEntryEmail in logEntryEmails)
            {
                strbldr.Append(logEntryEmail.Date.ToShortDateString() + " " + logEntryEmail.Date.ToShortTimeString() + ';');
                strbldr.Append(logger.GetStatus(logEntryEmail) + ';');
                strbldr.Append(logEntryEmail.Receiver + ';');
                strbldr.Append(logEntryEmail.DataType + ';');
                strbldr.Append(logEntryEmail.DataAction + ';');
                strbldr.Append(logEntryEmail.Body + ';');
                if (String.IsNullOrEmpty(logEntryEmail.Error))
                    strbldr.Append("Nessun messaggio d'errore" + ';');
                else
                    strbldr.Append(logEntryEmail.Error + ";");
                strbldr.Append("\n");
            }
            return strbldr;
        }

        public void Dispose()
        {

        }
    }
}