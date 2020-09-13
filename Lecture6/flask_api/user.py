from pynamodb.models import Model
from pynamodb.attributes import UnicodeAttribute
from pynamodb.attributes import NumberAttribute
from pynamodb.attributes import ListAttribute

class User(Model): # inheritance
    class Meta:
        table_name = "User"
        region = 'us-east-1'
    
    email = UnicodeAttribute(hash_key=True)
    password = UnicodeAttribute()
    phoneNumber = UnicodeAttribute()

    reservations = ListAttribute()

        