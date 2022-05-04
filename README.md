#NicePhotoApp - Development Diary

##May 4 - 12:17##

I read the Take-home exercise to understand what needs to be done. As part 1 is the most important, the focus will be on the frontend, so I'll start researching layout references. The sites that will be used for searching will be https://dribbble.com/shots/ and https://mobbin.design/browse/ios/screens

##May 4 - 12:35##

The onboarding screens will be based on the mockup: https://dribbble.com/shots/16540320-Onboarding-Screens. There will be three screens explaining how the dismiss and favorite process works in the app.

##May 4 - 13:10##

After the research, the decision was made to make the main screen of the app in using a **List**, as it is necessary to use the swipe gesture feature to favorite and dismiss the photos. Using a **Grid** (more common for apps that display photos) it is not possible to use this feature.

##May 4 - 13:10##

In order to make the onbording screens work, it will be necessary to use **UserDefaults** so that it is shown only once. A service will be created to avoid the need to work with strings and encapsulate its use.


Antes de começar a escrever qualquer código, vou estruturar todo a ideia do aplicativo, incluindo telas, navegações e arquitetura. 


// sobre arquitetura
 A arquitetura pedida no desafio foi o MVVM, um padrão de arquitetura simples  que encaixa muito bem com SwiftUI. Ela não descarta o fato de que as camadas abaixo do View Model podem ter uma estrutura bem definida. Uma das mais utilizadas atualmente no mercado é a Clean Arch, que será usada nesse desafio.   
