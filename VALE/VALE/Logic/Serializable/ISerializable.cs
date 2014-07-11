using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VALE.Logic.Serializable
{
    interface ISerializable
    {
        void SaveData<T>(T dati, string nomeFile);
        T ReadData<T>(string nomeFile);
    }
}
