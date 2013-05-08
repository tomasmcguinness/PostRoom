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
        private PostManager postManager;

        public ResidentManager()
        {
            context = new PostRoomDataContext();
            postManager = new PostManager();
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
            existingResident.AlertOnNewParcel = alertOnNewParcel;
            existingResident.DeviceIdentifier = deviceIdentifier;
            context.SaveChanges();
        }

        public int GetNumberOfItemsToCollection(string uniqueUserIdentifier)
        {
            long apartmentId = GetApartmentIdForResident(uniqueUserIdentifier);
            int totalPackages = postManager.GetTotalOutstandingPackagesForApartment(apartmentId);
            return totalPackages;
        }

        private long GetApartmentIdForResident(string uniqueUserIdentifier)
        {
            var apartmentId = context.Residents.Where(r => r.UniqueIdentifier == uniqueUserIdentifier).Select(a => a.ApartmentId).Single();
            return apartmentId;
        }
    }
}
