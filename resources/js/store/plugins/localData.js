const state = {
    row: {},
    formTeplate: {},
    component:null
}
//actions seems to work like signatures
const actions = {
    saveRowFormData({ commit }, data) {
        
        commit('setRowData', data);
        commit('setLocalStorage');
    },
    loadLocalRow({ commit }, data) {
        commit('setComponent',data);
        commit('loadLocalRow');
    },
    loadLocalRowStored({ commit }, cb) {
        if (cb) {
            cb();
        }
    },
}

const mutations = {
    setComponent(state, data) {
        state.component = data;
    },
    loadLocalRow(state) {
        if(localStorage.getItem("rowData")) {
            state.component.form = JSON.parse(localStorage.getItem("rowData"))
            console.log(state.component);
        }
    },

    setRowData(state, data) {
        console.log(data);
        state.row = data;
        
    },

    setLocalStorage(state) {
        if (state.row) {
            
            
            localStorage.setItem('rowData', JSON.stringify(state.row));
            
        }
    },

}

const getters = {
    getLocalRow: state => {
        return localStorage.getItem("rowData") ? JSON.parse(localStorage.getItem("rowData")).form : {};
    },
}

export default {
    namespaced: true,
    state,
    actions,
    mutations,
    getters

}