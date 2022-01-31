from django.urls import path
from admin import views

urlpatterns = [
    path('manage/', views.show_admin, name = 'admin'),
    path('manage/customer-list/', views.AdminCustomerListView.as_view(), name = 'admin-customer-list'),
    path('manage/book-list/', views.AdminBookListView.as_view(), name = 'admin-book-list'),
]
