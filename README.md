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
  - [x] Cell size is dynamic depending on length of strings in cell because strings wrap
  - [x] Custom pull to refresh
  - [x] New products are appended when scrolling to the bottom with loading indicator
  - [x] Search Bar allows you to search for particular product
- [x] CollectionvView
  - [x] CollectionView on detail screen allows your to scroll left and right to view more products
  - [x] Short description is put into a attributed string


- [] Simple icon and splash screen

## Notes

Challenges included doing async imageLoading and caching manually. (I'm use to using AFNetworking or AlamoFire) UI is done in storyBoard. MVVM design pattern. I followed these practices for writing swift https://github.com/github/swift-style-guide.


## License

    Copyright [2017] [Brandon aubrey]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


