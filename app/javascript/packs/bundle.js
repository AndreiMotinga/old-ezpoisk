/* eslint no-console:0 */
// this file includes all vendor js used throughout entire app
// To reference this file, use <%= javascript_pack_tag 'application' %>

import jQuery from 'jquery'
window.jQuery = jQuery

import 'jquery-ui/ui/widgets/autocomplete'
import 'jquery-ui/ui/widgets/datepicker'
import {} from 'jquery-ujs'
import 'bootstrap'

import 'select2'
import "../vendor/select_init"

import "timeago"
jQuery.timeago.settings.lang="ru"

import "jquery-sticky"
import "../vendor/sticky_init"

import "summernote-webpack"
import "../vendor/summernote_init"

import "../vendor/pgwslider"
import "../vendor/touchTouch"

import "old/components/users/header"
import "old/components/login_link"
import "old/components/navbar"
import "old/components/partner"
import "old/components/sliding_panel"

import "old/listings/copy"
import "old/listings/form"
import "old/listings/search"
import "old/questions/search"

import "old/bootstrap_init"
import "old/comments"
import "old/pagination"
import "old/partners"
import "old/scroll_up"
import "old/search_form"
import "old/search_highlight"
import "old/sw_cleanup"
import "old/update_cities"
