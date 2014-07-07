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
    class EventActionsTest
    {
        private EventActions eventActions;

        [SetUp]
        public void SetUp()
        {
            eventActions = new EventActions();
        }

        [TearDown]
        public void TearDown()
        {

        }

        [Test]
        public void event_should_get_filteredData_withEmptyDisctionary()
        {
            List<Event> projs = new List<Event>();
            var dictionary = new Dictionary<string, string>();

            projs.Add(new Event { EventDate = new DateTime(2000, 1, 1) });
            projs.Add(new Event { EventDate = new DateTime(2000, 2, 2) });
            projs.Add(new Event { EventDate = new DateTime(2000, 3, 3) });

            Assert.IsNull(eventActions.GetFilteredData<Event>(dictionary, projs));

        }

        [Test]
        public void event_should_get_filteredData_wrongValue()
        {
            List<Event> projs = new List<Event>();
            var dictionary = new Dictionary<string, string>();

            projs.Add(new Event { EventDate = new DateTime(2000, 1, 1) });
            projs.Add(new Event { EventDate = new DateTime(2000, 2, 2) });
            projs.Add(new Event { EventDate = new DateTime(2000, 3, 3) });

            dictionary.Add("fromDate", new DateTime(2000, 4, 4).ToShortDateString());
            dictionary.Add("toDate", new DateTime(1999, 4, 4).ToShortDateString());

            Assert.IsTrue(eventActions.GetFilteredData<Event>(dictionary, projs).Count == 0);

        }

        [Test]
        public void event_should_get_filteredData_byFromDate()
        {

            List<Event> projs = new List<Event>();
            var dictionary = new Dictionary<string, string>();

            projs.Add(new Event { EventDate = new DateTime(2000, 1, 1) });
            projs.Add(new Event { EventDate = new DateTime(2000, 2, 2) });
            projs.Add(new Event { EventDate = new DateTime(2000, 3, 3) });

            dictionary.Add("fromDate", new DateTime(2000, 2, 3).ToShortDateString());
            dictionary.Add("toDate", new DateTime(3000, 12, 31).ToShortDateString());

            Assert.IsTrue(eventActions.GetFilteredData<Event>(dictionary, projs).Count == 1 &&
                          eventActions.GetFilteredData<Event>(dictionary, projs).FirstOrDefault().EventDate == new DateTime(2000, 3, 3));

            projs.Add(new Event { EventDate = new DateTime(2000, 3, 3) });
            Assert.IsTrue(eventActions.GetFilteredData<Event>(dictionary, projs).Count == 2);
            foreach (var elem in eventActions.GetFilteredData<Event>(dictionary, projs))
                Assert.IsTrue(elem.EventDate.Year == 2000 && elem.EventDate.Month == 3);

        }

        [Test]
        public void event_should_get_filteredData_byToDate()
        {

            List<Event> projs = new List<Event>();
            var dictionary = new Dictionary<string, string>();

            projs.Add(new Event { EventDate = new DateTime(2000, 1, 1) });
            projs.Add(new Event { EventDate = new DateTime(2000, 2, 2) });
            projs.Add(new Event { EventDate = new DateTime(2000, 3, 3) });

            dictionary.Add("fromDate", new DateTime(1, 1, 1).ToShortDateString());
            dictionary.Add("toDate", new DateTime(2000, 1, 3).ToShortDateString());

            Assert.IsTrue(eventActions.GetFilteredData<Event>(dictionary, projs).Count == 1 &&
                          eventActions.GetFilteredData<Event>(dictionary, projs).FirstOrDefault().EventDate == new DateTime(2000, 1, 1));

            projs.Add(new Event { EventDate = new DateTime(2000, 1, 1) });
            Assert.IsTrue(eventActions.GetFilteredData<Event>(dictionary, projs).Count == 2);
            foreach (var elem in eventActions.GetFilteredData<Event>(dictionary, projs))
                Assert.IsTrue(elem.EventDate.Year == 2000 && elem.EventDate.Month == 1);

        }

        [Test]
        public void event_should_get_filter_concat()
        {
            List<Event> projs = new List<Event>();

            projs.Add(new Event { EventDate = new DateTime(2000, 1, 1) });
            projs.Add(new Event { EventDate = new DateTime(2000, 2, 2) });
            projs.Add(new Event { EventDate = new DateTime(2000, 3, 3) });

            var dictionary = new Dictionary<string, string>();

            dictionary.Add("fromDate", new DateTime(2000, 1, 3).ToShortDateString());
            dictionary.Add("toDate", new DateTime(2000, 2, 4).ToShortDateString());

            Assert.IsTrue(eventActions.GetFilteredData<Event>(dictionary, projs).Count == 1 &&
                          eventActions.GetFilteredData<Event>(dictionary, projs).FirstOrDefault().EventDate == new DateTime(2000, 2, 2));;
        }
    }
}
