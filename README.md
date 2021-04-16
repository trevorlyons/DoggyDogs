# DoggyDogs

## 📱Specification

The first screen should request a list of dog breeds from the Dogs API (https://dog.ceo/dog-api/) and present the result in a scrolling list.
Tapping a breed from the first list should present the second screen.
The second screen should show 10 random dog images of the selected breed.
Please zip and send the project when you're done, and include a README containing a brief description of your implementation.

## ✅ Acceptance Criteria

As a user running the application I can select breed from the list So that I can view pictures of that breed

Scenario: Viewing the breed list When I launch the app Then I see a list of dog breeds

Scenario: Viewing pictures of breed Given I have launched the app When I select a breed from the list Then I see 10 images of the breed

## Notes

Hello,

The project I have put together opens to a list of dog breeds. Selecting any breed presents a a second view containing a collectionView with up to 10 images of that breed. I have purposefully removed the sub-breeds from the initial dog breeds response as that would require a different network call to get sub-breed images. This would be easily handled for a future lovely addition as the breeds being the header for sections and the sub-breeds the data within each section.

Beyond those basics, I have used an mvvm pattern using Combine to make a state value on each viewModel observable by their associated view. When that state object is updated the views will update accordingly.

Along with the mvvm pattern I have used a repository pattern to manage dependency injection into the viewModels. This allows quick and easy mocking of any dependencies a viewModel may have as shown in the little unit test that I have included.

I have chosen to do the networking using Combine as well; returning a Publisher in place of using completion blocks. This allows for wonderful network call chaining, mapping of network call results, improved error handling, plus much more!
I thought a little bit about how I wanted to handle a failed response from the api and eventually went with a method that requires a bit of code duplication. I have made a note on one of the models showing an alternative generic model that could also have done the job.

My end goal with this simple project was to produce something that was clean and very easy to read/ follow while showing some of the patterns I like to use in my development process.

Thanks,

Trevor

