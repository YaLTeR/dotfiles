import QtQuick
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string displayText: {
        let name = NiriService.getCurrentKeyboardLayoutName();
        if (name.startsWith("English")) {
            return ":)";
        } else if (name.startsWith("Russian")) {
            return ":P";
        } else {
            return ":?";
        }
    }

    pillClickAction: () => {
        NiriService.cycleKeyboardLayout();
    }

    horizontalBarPill: Component {
        StyledText {
            text: root.displayText
            font.pixelSize: Theme.barTextSize(root.barThickness, root.barConfig?.fontScale)
            color: Theme.widgetTextColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    verticalBarPill: Component {
        StyledText {
            text: root.displayText
            font.pixelSize: Theme.barTextSize(root.barThickness, root.barConfig?.fontScale)
            color: Theme.widgetTextColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
