import QtQuick
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins
import Quickshell.Io
import Quickshell.Services.Pipewire

PluginComponent {
    id: root
    visible: NiriService.hasCasts

    function formatTarget(target) {
        if (target.Window) {
            const windowId = target.Window.id
            const window = NiriService.windows.find(w => w.id === windowId)
            if (window && window.title) {
                return "Window " + window.title
            }
            return "Window " + windowId
        } else if (target.Output) {
            return "Output " + target.Output.name
        } else if (target.Nothing) {
            return "Nothing"
        }
        return "Unknown"
    }

    function stopCast(sessionId) {
        return NiriService.send({
            "Action": {
                "StopCast": {
                    "session_id": sessionId
                }
            }
        });
    }

    horizontalBarPill: Component {
        DankIcon {
            name: NiriService.hasCasts ? "screen_record" : "circle"
            size: Theme.iconSize - 6
            color: NiriService.hasActiveCast ? Theme.primary : Theme.surfaceText
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    verticalBarPill: Component {
        DankIcon {
            name: NiriService.hasCasts ? "screen_record" : "circle"
            size: Theme.iconSize - 6
            color: NiriService.hasActiveCast ? Theme.primary : Theme.surfaceText
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    popoutContent: Component {
        PopoutComponent {
            id: popout

            headerText: "Screencasts"
            detailsText: NiriService.casts.length + " active"
            showCloseButton: true

            Column {
                id: popoutContentColumn
                width: parent.width
                spacing: Theme.spacingS

                Repeater {
                    model: NiriService.casts

                    StyledRect {
                        id: r
                        width: popoutContentColumn.width
                        height: castRow.height + Theme.spacingS * 2
                        radius: Theme.cornerRadius
                        color: Theme.surfaceContainerHigh

                        property string pidFormat: modelData.pid ? ` (PID ${modelData.pid})` : ""
                        property var consumerLinkGroup: {
                            if (!modelData.pw_node_id) return null
                            for (let i = 0; i < Pipewire.linkGroups.values.length; i++) {
                                const lg = Pipewire.linkGroups.values[i]
                                if (lg.source && lg.source.id === modelData.pw_node_id) {
                                    return lg
                                }
                            }
                            return null
                        }
                        property string pwNodeDisplay: {
                            if (consumerLinkGroup && consumerLinkGroup.target) {
                                return ` (${consumerLinkGroup.target.name})`
                            } else if (modelData.pw_node_id) {
                                return ` (PW node ${modelData.pw_node_id})`
                            }
                            return ""
                        }

                        Process {
                            running: modelData.pid !== undefined && modelData.pid !== null
                            command: ["bash", "-c", `basename "$(readlink /proc/${modelData.pid}/exe 2>/dev/null)" || echo "PID ${modelData.pid}"`]

                            stdout: StdioCollector {
                                onStreamFinished: {
                                    const output = this.text.trim()
                                    r.pidFormat = ` (${output})`
                                }
                            }
                        }

                        Row {
                            id: castRow
                            width: parent.width - Theme.spacingS * 2
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.spacingS
                            anchors.top: parent.top
                            anchors.topMargin: Theme.spacingS
                            spacing: Theme.spacingXS

                            Rectangle {
                                id: stopButton
                                anchors.verticalCenter: parent.verticalCenter
                                width: Theme.iconSize - 8
                                height: Theme.iconSize - 8
                                radius: (Theme.iconSize - 8) / 2
                                color: stopMouseArea.containsMouse ? Qt.rgba(Theme.error.r, Theme.error.g, Theme.error.b, 0.2) : "transparent"
                                visible: modelData.kind === "PipeWire"

                                DankIcon {
                                    anchors.centerIn: parent
                                    name: "close"
                                    size: Theme.iconSize - 8
                                    color: Theme.surfaceText
                                }

                                MouseArea {
                                    id: stopMouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        root.stopCast(modelData.session_id)
                                    }
                                }
                            }

                            DankIcon {
                                name: "screen_record"
                                size: Theme.iconSize - 8
                                color: modelData.is_active ? Theme.primary : Theme.surfaceText
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            StyledText {
                                text: "#" + modelData.stream_id +
                                      " • " + modelData.kind +
                                      r.pidFormat +
                                      r.pwNodeDisplay +
                                      (modelData.is_dynamic_target ? " • Dynamic" : "") +
                                      " • Session #" + modelData.session_id +
                                      " • " + root.formatTarget(modelData.target)
                                font.pixelSize: Theme.fontSizeMedium
                                color: Theme.surfaceText
                                anchors.verticalCenter: parent.verticalCenter
                                wrapMode: Text.Wrap
                                width: parent.width - Theme.iconSize
                            }
                        }
                    }
                }
            }
        }
    }

    popoutWidth: 600
    popoutHeight: Math.min(400, 100 + NiriService.casts.length * 80)
}
