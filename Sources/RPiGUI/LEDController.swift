import SwiftyGPIO

class LEDController {
  enum LED {
    case red, green, blue
  }
  
  private let gpios = SwiftyGPIO.GPIOs(for: .RaspberryPi3)
  
  private let redLEDGPIO: GPIO
  private let greenLEDGPIO: GPIO
  private let blueLEDGPIO: GPIO
  
  private let allLEDGPIOs: [GPIO]
  
  init() {
    // Physical Pin -> GPIO Mapping
    // 7 -> P4
    // 11 -> P17
    // 13 -> P27
    
    guard let redLEDGPIO = gpios[.P4], let greenLEDGPIO = gpios[.P17], let blueLEDGPIO = gpios[.P27] else {
      fatalError("Unable to configure GPIOs")
    }
    
    self.redLEDGPIO = redLEDGPIO
    self.greenLEDGPIO = greenLEDGPIO
    self.blueLEDGPIO = blueLEDGPIO
    
    allLEDGPIOs = [redLEDGPIO, greenLEDGPIO, blueLEDGPIO]
    
    #if !os(macOS)
    allLEDGPIOs.forEach { $0.direction = .OUT }
    #endif
    
    set(on: true, for: .red)
  }
  
  private func GPIO(for LED: LED) -> GPIO? {
    switch LED {
    case .red: return redLEDGPIO
    case .green: return greenLEDGPIO
    case .blue: return blueLEDGPIO
    }
  }
  
  func set(on: Bool, for led: LED) {
    print("Set LED '\(led)' to '\(on ? "on" : "off")'")
    #if !os(macOS)
    GPIO(for: led)?.value = on ? 1 : 0
    #endif
  }
  
  func reset() {
    #if !os(macOS)
    print("Set red, green & blue GPIOs to OFF and direction IN!")
    
    allLEDGPIOs.forEach {
      $0.value = 0
      $0.direction = .IN
    }
    #endif
  }
  
}
