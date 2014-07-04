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
        bool AddOrRemoveUserData(int dataId, string username);

        bool IsUserRelated(int dataId, string username);
        bool IsGroupRelated(int dataId, int groupId);

        bool SaveData<T>(T data);
        
        IQueryable<UserData> GetRelatedUsers(int _dataId);
        IQueryable<Group> GetRelatedGroups(int _dataId);
    }
}
