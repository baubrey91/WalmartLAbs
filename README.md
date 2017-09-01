# WalmartLabs

## User Stories

The following functionality is completed:

- [x] Images 
   - [x] Loaded asynchronous
   - [x] Put in cache
   - [x] Image is checked to make sure it is put in the correct cell
   - [x] Images fade in when loaded for first time
   
- [x] Main TableView 
  - [x] Data is repulled once app is re-opened with observer in appDelegate
  - [x] Cell size is dynamic depending on length of strings in cell because some strings wrap
  - [x] Custom pull to refresh (re-used from old project)
  - [x] New products are appended when scrolling to the bottom with loading indicator
  - [x] Search Bar allows you to search for particular product (not case sensative)
  - [x] Rating is color coded

- [x] CollectionvView
  - [x] CollectionView on detail screen allows your to scroll left and right to view more products
  - [x] Short description is put into a attributed string
  - [x] User taps on description to have image flip over
  
- [x] API
  - [x] Internet connection is checked and pop up alerts if there is non
  - [x] Data is automatically refreshed when re-opening app with observer set in delegate
  - [x] Some test written to check api (200 code etc)

## Notes

I didn't want to add a lot of features/ animations/ nice UI. I tried to keep it simple and clean as possible. Followed Swift coding standards here -> https://github.com/raywenderlich/swift-style-guide.
Challenges included doing async imageLoading and caching manually.(I'm use to using AFNetworking or AlamoFire) UI is done in storyBoard. MVVM design pattern. I followed these practices for writing swift https://github.com/github/swift-style-guide.


