
const BaseRouter = { template: '<router-view></router-view>'}
import PostsAdmin from './components/Modules/Posts/Admin.vue';
import PostsForm from './components/Modules/Posts/Form.vue';
import PostsFormReadOnly from './components/Modules/Posts/FormReadOnly.vue';
import UsersAdmin from './components/Modules/Users/Admin.vue';
import Reports from './components/Modules/Reports/Reports.vue';
import Settings from './components/Modules/Settings/Settings.vue';
import EndUserProjects from './components/Modules/EndUserProjects/EndUserProjects.vue';
import EndUserDownloads from './components/Modules/EndUserDownloads/EndUserDownloads.vue';
import EndUserFavorites from './components/Modules/EndUserFavorites/EndUserFavorites.vue';
import PageNotFound from './components/Modules/Error/PageNotFound.vue';

export const routes = [
    {
        path:'/',
        component:PostsAdmin,
        name: 'postsadmin'
    },
    {
        path:'/createPost',
        component:PostsForm,
        name: 'postsform'
    },
    {
        path:'/updatePost',
        component:PostsForm,
        name: 'updatePost'
    },
    {
        path:'/checkOutPost',
        component:PostsFormReadOnly,
        name: 'checkOutPost'
    },
    {
        path:'/adminUsers',
        component:UsersAdmin,
        name: 'adminusers'
    },
    {
        path:'/reports',
        component:Reports,
        name: 'reports'
    },
    {
        path:'/settings',
        component:Settings,
        name: 'settings'
    },
    {
        path:'/enduserprojects',
        component:EndUserProjects,
        name: 'enduserprojects'
    },
    {
        path:'/enduserdownloads',
        component:EndUserDownloads,
        name: 'enduserdownloads'
    },
    {
        path:'/enduserfavorites',
        component:EndUserFavorites,
        name: 'enduserfavorites'
    },

    { path: "*", component: PageNotFound }
  
];
