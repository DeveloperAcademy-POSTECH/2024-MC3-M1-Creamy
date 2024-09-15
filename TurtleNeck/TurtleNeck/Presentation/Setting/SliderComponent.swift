import SwiftUI

struct NSSliderView: NSViewRepresentable {
    @Binding var value: Double
    var minValue: Double
    var maxValue: Double
    var countOfMark: Int
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: NSSlider) {
            self.value.wrappedValue = sender.doubleValue
        }
    }
    
    
    func makeCoordinator() -> NSSliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeNSView(context: Context) -> some NSView {
        let slider = NSSlider(value: self.value, minValue: self.minValue, maxValue: self.maxValue, target: context.coordinator, action: #selector(Coordinator.valueChanged(_:)))
        slider.numberOfTickMarks = countOfMark
        slider.allowsTickMarkValuesOnly = true
        
        return slider
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        if let view = nsView as? NSSlider{
            view.doubleValue = value
        }
    }
}
