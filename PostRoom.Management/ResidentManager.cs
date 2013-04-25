using PostRoom.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
    public class ResidentManager
    {
        private PostRoomDataContext context;

        public ResidentManager()
        {
            context = new PostRoomDataContext();
        }

        public void AddResident(string uniqueIdentifier, long apartmentId)
        {
            Resident newResident = new Resident()
            {
                ApartmentId = apartmentId,
                UniqueIdentifier = uniqueIdentifier
            };

            context.Residents.Add(newResident);
            context.SaveChanges();
        }

        public void UpdateResident(string uniqueIdentifier, string deviceIdentifier, bool alertOnNewParcel)
        {
            var existingResident = context.Residents.Where(r => r.UniqueIdentifier == uniqueIdentifier).Single();
            existingResident.DeviceIdentifier = deviceIdentifier;
            existingResident.AlertOnNewParcel = alertOnNewParcel;
            context.SaveChanges();
        }

        public int GetNumberOfItemsToCollection(string uniqueUserIdentifier)
        {
            return 19;
        }
    }
}
