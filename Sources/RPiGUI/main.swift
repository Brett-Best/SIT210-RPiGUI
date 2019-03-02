import Gtk
import CGtk
import GLib

let ledController = LEDController()

func addRadioButtons(to box: Box) {
  let redGtkRadioButton = gtk_radio_button_new_with_label(nil, "Red LED")!
  let redLEDRadioButton = RadioButton(cPointer: redGtkRadioButton)
  box.packStart(child: redLEDRadioButton, expand: true, fill: true, padding: 8)
  
  let greenLEDRadioButton = RadioButton(label: SList(redLEDRadioButton.group), label: "Green LED")
  box.packStart(child: greenLEDRadioButton, expand: true, fill: true, padding: 8)
  
  let blueLEDRadioButton = RadioButton(label: SList(greenLEDRadioButton.group), label: "Blue LED")
  box.packStart(child: blueLEDRadioButton, expand: true, fill: true, padding: 8)
  
  redLEDRadioButton.connect(signal: .toggled) {
    ledController.set(on: redLEDRadioButton.active, for: .red)
  }
  
  greenLEDRadioButton.connect(signal: .toggled) {
    ledController.set(on: greenLEDRadioButton.active, for: .green)
  }
  
  blueLEDRadioButton.connect(signal: .toggled) {
    ledController.set(on: blueLEDRadioButton.active, for: .blue)
  }
}

func createWindow(application: ApplicationProtocol) -> ApplicationWindow {
  var window = ApplicationWindow(application: application)
  
  window.title = "RPiGUI - LED Controller"
  window.set(position: .center)
  window.setDefaultSize(width: 250, height: 200)
  
  let box = createBox(exitButtonTouched: {
    ledController.reset()
    application.quit()
  })
  
  window.add(widget: box)
  
  return window
}

func createBox(exitButtonTouched: @escaping (() -> Void)) -> Box {
  var box = Box(orientation: .vertical, spacing: 8)
  box.marginStart = 8
  box.marginEnd = 8
  box.halign = .center
  
  let label = Label(str: "Choose an LED to turn on.")
  box.packStart(child: label, expand: true, fill: true, padding: 8)
  
  addRadioButtons(to: box)
  
  var exitButton = Button(label: "Exit")
  exitButton.halign = .fill
  
  box.packStart(child: exitButton, expand: true, fill: true, padding: 8)
  
  exitButton.onButton { (_, _) in
    exitButtonTouched()
  }
  
  return box
}

let status = Application.run { app in
  let window = createWindow(application: app)
  window.showAll()
}

signal(SIGINT) { _ in
  ledController.reset()
}

guard let status = status else {
  fatalError("Could not create Application, unknown status.")
}

guard status == 0 else {
  fatalError("Application exited with status \(status).")
}
