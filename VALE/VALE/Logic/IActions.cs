using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    public interface IActions
    {
        bool AddOrRemoveUserData(int dataId, string username, string requestform);

        bool IsUserRelated(int dataId, string username);
        bool IsGroupRelated(int dataId, int groupId);

        bool IsStartedWork(string username);
        bool SaveData<T>(T data, UserOperationsContext db);
        
        IQueryable<UserData> GetRelatedUsers(int _dataId);
        IQueryable<Group> GetRelatedGroups(int _dataId);

        bool ComposeMessage(int dataId, string username, string subject);
    }
}
