// This JS library to add the tags on the Articles

var inputElm = document.querySelector('input[name=tags]');

function tagTemplate(tagData) {
    return `
    <tag title="${tagData.email}"
            contenteditable='false'
            spellcheck='false'
            tabIndex="-1"
            class="tagify__tag ${tagData.class ? tagData.class : ""}"
            ${this.getAttributes(tagData)}>
        <x title='' class='tagify__tag__removeBtn' role='button' aria-label='remove tag'></x>
        <div>
            <span class='tagify__tag-text'>${tagData.name}</span>
        </div>
    </tag>
`
}

function suggestionItemTemplate(tagData) {
    return `
    <div ${this.getAttributes(tagData)}
        class='tagify__dropdown__item ${tagData.class ? tagData.class : ""}'
        tabindex="0"
        role="option">
        ${tagData.avatar ? `
        <div class='tagify__dropdown__item__avatar-wrap'>
            <img onerror="this.style.visibility='hidden'" src="${tagData.avatar}">
        </div>` : ''
        }
        <strong>${tagData.name}</strong>
    </div>
`
}

// initialize Tagify on the above input node reference
var tagify = new Tagify(inputElm, {
    tagTextProp: 'name', // very important since a custom template is used with this property as text
    enforceWhitelist: true,
    maxTags: 3,
    skipInvalid: true,
    dropdown: {
        closeOnSelect: false,
        enabled: 0,
        classname: 'users-list',
        searchKeys: ['name']  // Search with the name
    },
    templates: {
        tag: tagTemplate,
        dropdownItem: suggestionItemTemplate
    },
    // Must come via Ajax request
    whitelist: [
        {
            "value": 4,
            "name": "Perl",
        },
        {
            "value": 5,
            "name": "Python",
        },
        {
            "value": 6,
            "name": "Others",
        }
    ]
})

tagify.on('dropdown:show dropdown:updated', onDropdownShow)
tagify.on('dropdown:select', onSelectSuggestion)

var addAllSuggestionsElm;

function onDropdownShow(e) {
    var dropdownContentElm = e.detail.tagify.DOM.dropdown.content;
}

function onSelectSuggestion(e) {
    if (e.detail.elm == addAllSuggestionsElm)
        tagify.dropdown.selectAll();
}