from pynamodb.models import Model
from pynamodb.attributes import UnicodeAttribute, NumberAttribute

class Reservation(Model): # inheritance
    class Meta:
        table_name = "Reservation"
        region = 'us-east-1'
    
    bookingId = UnicodeAttribute(hash_key=True)
    resName = UnicodeAttribute()
    numGuests = NumberAttribute()
    dateTs = NumberAttribute()
    resImage = UnicodeAttribute()