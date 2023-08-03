import { Application } from "@hotwired/stimulus"
import 'bootstrap' //aula 9 Precisar ser importado para a navbar e o Lauch demo modal funcionar 
//import 'application' //aula 9  PARECE NAO PRECISAR 
//import "@popperjs/core" // PARECE NAO PRECISAR 


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
