<template>
	<div REQUIRED-FOR-TEMPLATE="settings.settings">
		<div class="row text-center centeredFrom1100 upperRow">
			<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 py-3">
				<BodyHeaderPart1 :mode="'admin'" :actionData="null"/>
				<SettingsCategories/>
				<SettingsTags/>
				<SettingsUsersTypes />
				<SettingsOutgoingemailserver :sections="sections" />
			</div>
		</div>
	</div>
</template>

<script>
import BodyHeaderPart1 from "../../AppTemplate/Body/BodyHeaderPart1";
import SettingsCategories from "./Categories/Categories";
import SettingsTags from "./Tags/Tags";
import SettingsUsersTypes from "./UsersTypes/UsersTypes";
import SettingsOutgoingemailserver from "./Outgoingemailserver/Outgoingemailserver";
export default {
	name: "settings",
	components: {
		BodyHeaderPart1,
		SettingsCategories,
		SettingsTags,
		SettingsUsersTypes,
		SettingsOutgoingemailserver
	},
	data() {
		return {
			sections: {
				outgoingEmailServer: {
					form: {
						APIKEY: "https://secure.placetopay.com/redirection/",
						outgoingEmail: "61a04a78554d916f42cbd3630377a6bb",
						accountPassword: "l91590alH9O0c0hZ"
					}
				}
			}
		};
	},
};
</script>

<style lang="scss" >
.row-card {
	box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
	background: #e6e6e6;
}
.row-card-white {
	box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
	background: #fff;
}
.row-card-sides {
	// box-shadow: -13px  0px -5px rgba(0, 0, 0, 0.2), -13px 0px 5px rgba(0, 0, 0, 0.19);
	box-shadow: -3px 0px 5px rgba(0, 0, 0, 0.19),
		3px 0px 5px rgba(0, 0, 0, 0.19);
	background: #e6e6e6;
}
.upperRow {
	position: relative;
	top: -95px;
}

.border-category {
	border: 1px solid #dadada;
	padding: 9px 1px 9px 1px;
	border-radius: 6px;
}
.categoryShadow {
	
	box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
}

.row-card-darkgray {
	background-color: rgb(204, 204, 211);
	box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
}

.table-header {
	box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;;
	background-color: #0065cb;
	color: #fff;
	font-size: 15px;
}

.table-body-border {
	box-shadow: 0px 0px 0px #c2c2c238, 0px 3px 4px 0px #dcd9d985;
}

.input-yellow-backg-color {
	background: #fff5d6 !important;
}
</style>