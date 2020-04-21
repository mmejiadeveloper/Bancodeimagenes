<template>
    <div REQUIRED-FOR-TEMPLATE="body" class="bkcolor">
        <transition>
            <keep-alive>
                <router-view></router-view>
            </keep-alive>
        </transition>
    </div>
</template>

<script>
    export default {
        name : 'app-body',
    }
</script>

<style lang="css" scoped>
.row{
    margin-left: 0px;
    margin-right: 0px;
}
.bkcolor{
    background-color: #f1f1f1;
}
</style>