export default {
    name: 'custom-modal',
    install(Vue, options = {}) {
        Vue.prototype.$CustomModal = {
            data: {
                lastModalFloatingElementIds: [],
                lastModalFloatingZindexPropierties: [],
                lastModalFloatingElementVueinstanceRef: '',
                lastModalFloatingOpeningBoolPropierty: false,
                objectReferenceByKeyName: '',
                lastModalFloatingElementComingFromVRoute: false,
            },
            actions: {
                //open
                openCustomModal: (ids, ref, keyName, callback = null, componentFromVRoute = false) => {
                    try {
                        Vue.prototype.$CustomModal.actions.setFloatingModalElementPropierties(ids, ref, keyName, componentFromVRoute);
                        Vue.prototype.$CustomModal.actions.applyFloatingModalPropiertiesAndOpenModal(ids);
                        if (callback) {
                            callback();
                        }
                    } catch (error) {
                        alert(error.message);
                    }

                },

                setFloatingModalElementPropierties: (ids, ref, keyName, componentFromVRoute) => {
                    Vue.prototype.$CustomModal.data.lastModalFloatingElementIds = ids;
                    Vue.prototype.$CustomModal.data.lastModalFloatingElementVueinstanceRef = ref;
                    Vue.prototype.$CustomModal.data.objectReferenceByKeyName = keyName;
                    Vue.prototype.$CustomModal.data.lastModalFloatingElementComingFromVRoute = componentFromVRoute;
                    ids.forEach(element => {
                        Vue.prototype.$CustomModal.data.lastModalFloatingZindexPropierties.push($('#' + element).css('z-index'));
                    });
                },

                applyFloatingModalPropiertiesAndOpenModal: (ids) => {
                    ids.forEach(element => {
                        $('#' + element).css('z-index', '110');
                        var positionValue = $('#' + element).css('position');
                        $('#' + element).css('position', positionValue == 'absolute' ? 'absolute' : 'relative');
                    });
                    $('.customModal').height($('#app').height());
                    $('.customModal').show();
                },

                //close
                closeCustomModal: (callback = null) => {
                    try {
                        $('.customModal').hide();
                        Vue.prototype.$CustomModal.actions.detectComponentCaptureModeAndDecideAction();
                        if (callback) {
                            callback();
                        }
                    } catch (error) {
                        alert(error.message);
                    }

                },

                detectComponentCaptureModeAndDecideAction: () => {
                    //El modo de captura es si el elemento modal que se esta abriendo pertenecer a un REF de vue o no
                    if (Vue.prototype.$CustomModal.data.lastModalFloatingElementComingFromVRoute) {
                        //Esto es lo que ocurre cuando no se envia un REF
                        Vue.prototype.$CustomModal.actions.selectObjectById(Vue.prototype.$CustomModal.data.objectReferenceByKeyName, window.currentVrouteComponent['toggleData'][Vue.prototype.$CustomModal.data.objectReferenceByKeyName]['filter']);
                        Vue.prototype.$CustomModal.actions.restoreFloatingElementPropiertes();
                    } else {
                        //Esto es lo que ocurre cuando se envia un REF
                        var refDomElement = window.root.$refs.dashboard.$refs[Vue.prototype.$CustomModal.data.lastModalFloatingElementVueinstanceRef];
                        Vue.prototype.$CustomModal.actions.findInVueinstaceData(refDomElement);
                    }
                },

                selectObjectById: (keyName, _dataVueInstancePropiety) => {
                    if (keyName == Vue.prototype.$CustomModal.data.objectReferenceByKeyName) {
                        Vue.prototype.$CustomModal.actions.findCloseableObjectPropiertyWhichAppliesTo(_dataVueInstancePropiety);
                    }
                },

                findCloseableObjectPropiertyWhichAppliesTo: (_dataVueInstancePropiety) => {
                    //console.log(Vue.prototype.$CustomModal.data.objectReferenceByKeyName);
                    for (const skey in _dataVueInstancePropiety) {
                        if (_dataVueInstancePropiety.hasOwnProperty(skey)) {
                            const each_dataVueInstancePropieties = _dataVueInstancePropiety[skey];
                            Vue.prototype.$CustomModal.actions.verifyIfApliesAndCloseElement(_dataVueInstancePropiety, skey);
                        }
                    }
                },

                verifyIfApliesAndCloseElement: (_dataVueInstancePropiety, skey) => {

                    if (skey == 'appliesForCustomModalPlugin') {
                        if (_dataVueInstancePropiety[skey] == true) {
                            _dataVueInstancePropiety.visible = !_dataVueInstancePropiety.visible;
                        }
                    }
                },

                findInVueinstaceData: (refDomElement) => {
                    for (const key in refDomElement) {
                        if (refDomElement.hasOwnProperty(key)) {
                            let elementsInVueInstance = refDomElement[key];
                            if (key == "_data") {
                                Vue.prototype.$CustomModal.actions.findCloseableDomElementsForCustomModalPlugin(elementsInVueInstance);
                            }
                        }
                    }
                },

                findCloseableDomElementsForCustomModalPlugin: (domElement) => {

                    for (const key in domElement) {
                        if (domElement.hasOwnProperty(key)) {
                            const _dataVueInstancePropiety = domElement[key];
                            Vue.prototype.$CustomModal.actions.selectObjectById(key, _dataVueInstancePropiety);
                        }
                    }
                },

                closeLastFloatingElement: (refDomElement) => {
                    Vue.prototype.$CustomModal.actions.restoreFloatingElementPropiertes();
                    Vue.prototype.$CustomModal.actions.findInVueinstaceData(refDomElement);
                },

                restoreFloatingElementPropiertes: () => {
                    Vue.prototype.$CustomModal.data.lastModalFloatingElementIds.forEach((element, index) => {
                        $('#' + element)
                            .css('z-index', Vue.prototype.$CustomModal.data.lastModalFloatingZindexPropierties[index]);
                    });
                },

            }
        }

    }
}