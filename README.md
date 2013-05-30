#Notes

###Products 
- Products are never created on their own.  They always work in tandem with variants.
- Because of this, you're really never going to want to show @products.. it should really always be @variants...
###Variants
- Need to see if he uses SKUs


##VIEWS/BACKEND
###Product/variants
- I'd say display the product, then have a show variant tab that slides open to show all variants. Create Variant Button from index view and show view.

#NEXT
- Categories (prototypes)
- Images (you have to update Product.featured to include(:images), because a featured product has to have an image) see product.rb:: self.featured
- STOCK - how is he handling stock? - I'm thinking just boolean, which would let me skip inventory for now..
- All Properties, figure out how to do this at every level - if you even want them at all levels