<template>
</template>

<script>
    
    export default {
        name:'IGeneral',
        data() {
            return {
                licencia: {},
                sin_licecia: false,
                axios_licencia: null,
            }
        },
        methods: { 
            ajax_peticion(url, datos = null, callback = [], API = false) {
                try {
                    var formData = new FormData();
                    if (datos != null) {
                        var str_datos = JSON.stringify(datos);
                        formData.append("data", str_datos);
                    }
                    axios.post(url, formData, {
                            headers: {
                                "Content-type": "multipart/form-data"
                            }
                    })
                    .then(respuesta => {
                        if (callback.length > 0) {
                            callback.forEach(element => {
                                if (element != null) {
                                    element(respuesta.data);
                                }
                            });
                        }
                    });
                }
                catch(err) {
                    alert(err.message);
                }
                
            },

            vue_swal_error(mensaje, titulo = vginformacion, errorbtn = true, callback = null) {
                this.$swal({
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
         
            vue_swal_success(mensaje, titulo = vginformacion) {
                this.$swal({
                    type: 'success',
                    title: titulo,
                    text: mensaje,
                    showConfirmButton: false,
                })
            },
    
            vue_swal_successv2(mensaje, titulo = vginformacion, callback = null) {
                this.$swal({
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
        
            vue_swal_confirmacion(mensaje, titulo = vginformacion, callback = null) {

                this.$swal({
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
        
            verificar_licencia(callback = null) {
                if (this.axios_licencia == null) {
                    this.axios_licencia = this.ajax_peticion('ver_licencia', null, [(respuesta) => {
                        this.ajax_peticion == null;
                        if (respuesta.logeado) {
                            this.licencia = respuesta.licencia;
                            if (Object.keys(this.licencia).length > 1) {
                                // this.verificar_licencia();
                                this.ajax_peticion == null;
                            }
                            else {
                                this.vue_swal_error(respuesta.mensaje, 'Aviso', true, () => {
                                    location.href = '../logout';
                                });
                            }
                        }
                        if (callback != null) {
                            callback(respuesta.licencia);
                        }
                    }]);
                }
            },
        
            valida_formulario(idformulario) {
                /**
                * @see @VGC8.1
                */
                var dataform = $(idformulario).find('[required=required]');
                if (dataform.length > 0) {
                    var fallas = 0;
                    dataform.each(function (e) {
                        var that = this;
                        /**
                        * @see @VGC8.1.1
                        */
                        if (that.value == null || that.value == '') {
                            /**
                            * @see @VGC8.1.2
                            */
                            $("[for=" + that.id + "]").addClass('text-danger');
                            $(that).addClass('border-danger');
                            $(that).addClass('hvr-buzz-out');
                            /*setTimeout(function(){
                                $("[for="+that.id+"]").removeClass('text-danger');
                                $(that).removeClass('border-danger');
                                $(that).removeClass('hvr-buzz-out');
                            }, 3000);*/
                            fallas++;
                        }
                    });
                    /**
                    * @see @VGC8.2
                    */
                    if (fallas > 0) {
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                else {
                    return true;
                }
            },

            validarEmail(valor, id) {
                // Expresion regular para validar el correo
                var regex = /[\w-\.]{2,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w-]{2,4}/;

                if (regex.test(valor.trim())) {

                    $("[for=" + id + "]").removeClass('text-danger');
                    $("#" + id).removeClass('border-danger');
                    $("#" + id).removeClass('hvr-buzz-out');

                    return true;
                } else {

                    $("[for=" + id + "]").addClass('text-danger');
                    $("#" + id).addClass('border-danger');
                    $("#" + id).addClass('hvr-buzz-out');

                    return false;

                }
            },
 
            filtrar(url, objeto_filtros) {

                this.ajax_peticion(url, objeto_filtros, [(respuesta) => {
                    return respuesta;
                    console.log('------------------------------------');
                    console.log(respuesta);
                    console.log('------------------------------------');
                }]);

            },
            
            redondear_numero(num, precision) {
                precision = Math.pow(10, precision);
                return Math.ceil(num * precision) / precision;
            },
        },
        mounted() {
            // IGeneral =  this;
            this.$root.IGeneral = this;
        },
       
    }
</script>
