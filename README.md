#Notes

###Products 
-
###Variants
- Need to see if he uses SKUs
- Shift pricing from just price to another price range - this time for all the different weights.  Also a lowest price method.  
- Ability to add weights "on the fly" in the variant/product page

###Categories
- Need to display products by categories.

###Weights
- JS to automatically convert ounces to pounds in the weight new form.
##VIEWS/BACKEND
###Product/variants
- I'd say display the product, then have a show variant tab that slides open to show all variants. Variants that are not active should be greyed out.

#NEXT
- GroupBy Category on Product Page, and Also Filter by Category...
- Images (you have to update Product.featured to include(:images), because a featured product has to have an image) see product.rb:: self.featured
- STOCK - how is he handling stock? - I'm thinking just boolean, which would let me skip inventory for now..

