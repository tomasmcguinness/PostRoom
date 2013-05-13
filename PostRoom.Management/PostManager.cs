using PostRoom.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Management
{
  public class PostManager
  {
    private ResidentManager residentManager;
    private NotificationService notificationService;

    public PostManager()
    {
      residentManager = new ResidentManager();
      notificationService = new NotificationService();
    }

    public void RecordDelivery(long apartmentId, string recipient)
    {
      using (var ctx = new PostRoomDataContext())
      {
        ctx.Deliveries.Add(new Delivery()
        {
          ApartmentId = apartmentId,
          Recipient = recipient,
          DeliveryDate = DateTime.UtcNow
        });

        ctx.SaveChanges();

        NotifyDeliveryToApartment(apartmentId);
      }
    }

    private void NotifyDeliveryToApartment(long apartmentId)
    {
      var residents = residentManager.GetResidentsForApartment(apartmentId);
      var totalPackages = this.GetTotalOutstandingPackagesForApartment(apartmentId);

      foreach (var resident in residents)
      {
        if (string.IsNullOrEmpty(resident.UniqueIdentifier) || resident.UniqueIdentifier == "SIMULATOR-DEVICE-IDENTIFIER") continue;
        notificationService.SendiPhonePushNotification(resident.UniqueIdentifier, totalPackages, true);
      }
    }

    private void NotifyCollectionFromApartment(long apartmentId)
    {
      var residents = residentManager.GetResidentsForApartment(apartmentId);
      var totalPackages = this.GetTotalOutstandingPackagesForApartment(apartmentId);

      foreach (var resident in residents)
      {
        if (string.IsNullOrEmpty(resident.UniqueIdentifier) || resident.UniqueIdentifier == "SIMULATOR-DEVICE-IDENTIFIER") continue;
        notificationService.SendiPhonePushNotification(resident.UniqueIdentifier, totalPackages, false);
      }
    }

    public int GetNumberOfItemsToCollection(string uniqueUserIdentifier)
    {
      long apartmentId = residentManager.GetApartmentIdForResident(uniqueUserIdentifier);
      int totalPackages = GetTotalOutstandingPackagesForApartment(apartmentId);
      return totalPackages;
    }

    public int GetTotalOutstandingPackagesForBuilding(long buildingId)
    {
      using (var ctx = new PostRoomDataContext())
      {
        var package = (from d in ctx.Deliveries
                       join a in ctx.Apartments on d.ApartmentId equals a.ApartmentId
                       where a.BuildingId == buildingId && d.CollectionDate.HasValue == false
                       select d).Count();

        return package;
      }
    }

    internal int GetTotalOutstandingPackagesForApartment(long apartmentId)
    {
      using (var ctx = new PostRoomDataContext())
      {
        var package = (from d in ctx.Deliveries
                       join a in ctx.Apartments on d.ApartmentId equals a.ApartmentId
                       where a.ApartmentId == apartmentId && d.CollectionDate.HasValue == false
                       select d).Count();

        return package;
      }
    }

    public List<Delivery> GetItemsForCollection(long apartmentId)
    {
      using (var ctx = new PostRoomDataContext())
      {
        var deliveries = (from d in ctx.Deliveries
                          join a in ctx.Apartments on d.ApartmentId equals a.ApartmentId
                          where a.ApartmentId == apartmentId && d.CollectionDate.HasValue == false
                          select d);

        return deliveries.ToList();
      }
    }

    public void MarkDeliveryAsCollected(long deliveryId)
    {
      using (var ctx = new PostRoomDataContext())
      {
        var delivery = ctx.Deliveries.Find(deliveryId);
        delivery.CollectionDate = DateTime.UtcNow;
        ctx.SaveChanges();

        NotifyCollectionFromApartment(delivery.ApartmentId);
      }
    }

    public void MarkAllDeliveriesAsCollected(long apartmentId)
    {
      using (var ctx = new PostRoomDataContext())
      {
        var deliveries = (from d in ctx.Deliveries
                          join a in ctx.Apartments on d.ApartmentId equals a.ApartmentId
                          where a.ApartmentId == apartmentId
                          select d);

        foreach (var delivery in deliveries)
        {
          delivery.CollectionDate = DateTime.UtcNow;
        }

        ctx.SaveChanges();
      }
    }
  }
}
