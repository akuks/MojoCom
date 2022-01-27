/** 
This library is to submit the Ajax request And other common functionalities.
We are avoiding Jquery for slimmer builds
*/
async function appAjax(form) {
    let formData = new FormData();
    
    for ( let i = 0; i < form.length; i++ ) {
        formData.append(form[i].name, form[i].value);
    }
    
    let url = form.getAttribute('action');
    let method = form.getAttribute('method');

    return fetch(url, {
            method: method,
            body: formData
        }).then( function (response) {
            if ( response.ok ) {
                return response.json();
            }
            else {
               return  Promise.reject(response)
            }
        }).then( function (data) {
            return data
        }).catch( function (error) {
            console.warn('Something went wrong.', error);
            return error;
        });
}

function enableButton(button) {
    document.getElementById(button).disabled = false;
}

function disableButton(button) {
    document.getElementById(button).disabled = true;
}

// Get Element By Id
function getAppElementById(elementId) {
    return document.getElementById(elementId);
}

function getAppElementByClassName( elementId ) {
    return document.getElementByClassName(elementId);
}