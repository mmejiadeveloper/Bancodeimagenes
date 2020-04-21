@component('mail::message')
# Introduction

<span class="test" >fffff</span>

The body of your message.

@component('mail::button', ['url' => ''])
Button Text
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent
