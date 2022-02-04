/**
* This Class is to Set the editorjs configuration settings
 */
class MojoComEditorConfig {
    constructor(editor, csrf_token) {
        this.editor = editor;
        this.csrf_token = csrf_token;
    }

    get editorConfig() {
        return new EditorJS({
            /**
            * Set autofocus to True
            */
            autofocus: true,

            /**
            * Enable/Disable the read only mode
            */
            readOnly: false,

            /**
            * Wrapper of Editor
            */
            holder: this.editor,

            // Set Autofocus true
            autofocus: true,

            /**
            * Tools list
            */
            tools: {
                // Set Headers
                header: {
                    class: Header,
                    inlineToolbar: ['link', 'marker', 'bold', 'italic'],
                    config: {
                        placeholder: 'Title of the Article'
                    },
                    shortcut: 'CMD+SHIFT+H'
                },

                anyTuneName: {
                    class: AlignmentBlockTune,
                    config: {
                        placeholder: 'Alignment',
                        default: "left",
                        blocks: {
                            header: 'center',
                            list: 'right'
                        }
                    },
                },

                /**
                * Or pass class directly without any configuration
                */
                image: {
                    class: ImageTool,
                    config: {
                            additionalRequestHeaders: {
                            "X-CSRF-TOKEN": this.csrf_token
                        },
                        endpoints: {
                            byFile: 'http://localhost.0x484c.com:3000/upload/image'
                        }
                    }
                },

                list: {
                    class: List,
                    inlineToolbar: true,
                    shortcut: 'CMD+SHIFT+L'
                },

                checklist: {
                    class: Checklist,
                    inlineToolbar: true,
                },

                quote: {
                    class: Quote,
                    inlineToolbar: true,
                    config: {
                        quotePlaceholder: 'Enter a quote',
                        captionPlaceholder: 'Quote\'s author',
                    },
                    shortcut: 'CMD+SHIFT+O'
                },

                marker: {
                    class: Marker,
                    shortcut: 'CMD+SHIFT+M'
                },

                code: {
                    class: CodeTool,
                    shortcut: 'CMD+SHIFT+C'
                },

                inlineCode: {
                    class: InlineCode,
                    shortcut: 'CMD+SHIFT+C'
                },

                linkTool: LinkTool,

                embed: Embed,

                table: {
                    class: Table,
                    inlineToolbar: true,
                    shortcut: 'CMD+ALT+T'
                },

                paragraph: {
                    class: Paragraph,
                    inlineToolbar: true,
                },

            },

            /**
            * Initial Editor data
            */
            data: {
                blocks: [
                    {
                        type: "header",
                        data: {
                            text: "Post Title...",
                            level: 2
                        }
                    },
                    {
                        type: "paragraph",
                        data: {
                            text: "Write your content here..."
                        }
                    }
                ]
            },
        });
    }
}