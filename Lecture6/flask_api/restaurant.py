from pynamodb.models import Model
from pynamodb.attributes import UnicodeAttribute, NumberAttribute

class Restaurant(Model): # inheritance
    class Meta:
        table_name = "Restaurant"
        region = 'us-east-1'
    resName = UnicodeAttribute(hash_key=True)
    city = UnicodeAttribute()
    category1 = UnicodeAttribute()
    category2 = UnicodeAttribute()
    rating = NumberAttribute()
    image_url = UnicodeAttribute()
    priceRange = UnicodeAttribute()

