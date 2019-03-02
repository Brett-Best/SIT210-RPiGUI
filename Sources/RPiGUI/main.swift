import SwiftyGPIO
import Gtk
import CGtk
import GLib

let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi3)

let status = Application.run { app in
  var window = ApplicationWindowRef(application: app)
  window.title = "RPiGUI - LED Controller"
  window.set(position: .center)
  window.setDefaultSize(width: 200, height: 200)
  
  var box = Box(orientation: .vertical, spacing: 8)
  box.marginStart = 8
  box.marginEnd = 8
  
  let redGtkRadioButton = gtk_radio_button_new_with_label(nil, "Red LED")!
  let redLEDRadioButton = RadioButton(cPointer: redGtkRadioButton)
  box.packStart(child: redLEDRadioButton, expand: true, fill: true, padding: 8)
  
  let radioButtonGroup: SListProtocol! = SList(redLEDRadioButton.group)
  
  let greenLEDRadioButton = RadioButton(label: radioButtonGroup, label: "Green LED")
  box.packStart(child: greenLEDRadioButton, expand: true, fill: true, padding: 8)
  
  let blueLEDRadioButton = RadioButton(label: radioButtonGroup, label: "Blue LED")
  box.packStart(child: blueLEDRadioButton, expand: true, fill: true, padding: 8)
  
  let exitButton = Button(label: "Exit")
  box.packStart(child: exitButton, expand: true, fill: true, padding: 8)
  
  exitButton.onButton { (widget, event) in
//    guard let gp = gpios[.P4] else {
//      fatalError()
//    }
//
//    gp.direction = .OUT
//    gp.value = 1

    app.quit()
  }
  
  window.add(widget: box)
  window.showAll()
}

guard let status = status else {
  fatalError("Could not create Application, unknown status.")
}

guard status == 0 else {
  fatalError("Application exited with status \(status).")
}
