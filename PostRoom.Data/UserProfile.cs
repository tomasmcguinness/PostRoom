using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PostRoom.Data
{
    [Table("UserProfiles")]
    public class UserProfile
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public long UserProfileId { get; set; }
        public string EmailAddress { get; set; }
        public long EstateId { get; set; }
        public DateTime DateCreated { get; set; }
    }
}
