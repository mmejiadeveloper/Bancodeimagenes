export default {

    name: 'IGeneral',

    install(Vue, options = {}) {

        Vue.prototype.$IGeneral = {

            data: {

                details: false,

            },

            asyncRequest: (url, datos = null, callback = [], files = []) => {

                try {

                    var formData = new FormData();

                    if (datos != null) {

                        var str_datos = JSON.stringify(datos);

                        formData.append("data", str_datos);

                    }



                    if (files.length > 0) {

                        for (var i = 0; i < files.length; i++) {

                            let file = files[i];

                            formData.append('files[' + i + ']', file);

                        }

                    }

                    axios.post(url, formData, {

                        headers: {

                            "Content-type": "multipart/form-data"

                        }

                    })

                        .then(response => {

                            if (callback.length > 0) {

                                callback.forEach(responses => {

                                    let errorState = {};

                                    if (response.data.type == 3) {

                                        errorState.errorFlag = response.data.type != 1 ? true : false;

                                        errorState.errorMessage = response.data.type != 1 ? response.data.message : '';

                                    }

                                    if (Object.keys(errorState).length <= 0) {

                                        if (responses != null) {

                                            responses(response.data);

                                        }



                                    } else {

                                        if (datos) {

                                            if (datos.showErrorAtModal) {

                                                let errorDetailsHTML = response.data.details ? "<a onclick='$(\"#errorDetail\").toggle();' href = '#'> <br> Ver detalle <br> </a> <span style='display:none;' id='errorDetail'> " + response.data.details + "  </span> " : 'No existe detalle de lo ocurrido';

                                                if (errorState.errorFlag) {

                                                    Vue.prototype.$IGeneral.vue_swal_error(errorState.errorMessage + errorDetailsHTML, 'Error de sistema', false);

                                                }

                                            }

                                        }



                                    }

                                });

                            }

                        }).catch((error) => {

                            console.log('ERR,', error);



                            if (error) {

                                if (error.response) {

                                    if (error.response.status == 401) {

                                        Vue.prototype.$IGeneral.vue_swal_error('Usted esta intentando acceder u obtener informacion del sistema de una manera no autorizada, por favor primero ingrese al sistema de manera debida.', 'Error de autenticacion');

                                    }

                                }

                                console.error("ERROR", error);

                            }

                        });

                }

                catch (err) {

                    alert(err.message);

                }

            },



            vue_swal_confirmacion(mensaje, titulo = vginformacion, callback = null) {



                window.swal({

                    title: titulo,

                    text: mensaje,

                    type: 'question',

                    showCancelButton: true,

                    confirmButtonColor: '#3085d6',

                    cancelButtonColor: '#d33',

                    confirmButtonText: 'Si',

                    cancelButtonText: 'Cancelar'

                }).then((result) => {

                    if (result.value) {

                        if (callback != null) {

                            callback(result.value);

                        }

                    }

                });

            },



            vue_swal_success(mensaje, titulo = vginformacion) {

                window.swal({

                    type: 'success',

                    title: titulo,

                    text: mensaje,

                    showConfirmButton: false,

                })

            },



            vue_swal_successv2(mensaje, titulo = vginformacion, callback = null) {

                window.swal({

                    type: 'success',

                    title: titulo,

                    text: mensaje,

                    animation: true

                }).then((result) => {

                    if (callback != null) {

                        callback(result.value);

                    }

                });

            },



            vue_swal_error(mensaje, titulo = vginformacion, errorbtn = true, callback = null) {

                window.swal({

                    type: 'error',

                    title: titulo,

                    html: mensaje,

                    showConfirmButton: errorbtn,

                    allowOutsideClick: false

                }).then(() => {

                    if (callback != null) {

                        callback();

                    }

                })

            },



            vue_swal_loading(mensaje, titulo = '') {

                window.swal({

                    html: '<img src="img/AppTemplate/Login/spinner.gif" alt=""> <br> Estamos cargando tu recurso...',

                    showConfirmButton: false,

                })

            },

            vue_swal_close() {

                window.swal.close();

            },



        }

    }

}