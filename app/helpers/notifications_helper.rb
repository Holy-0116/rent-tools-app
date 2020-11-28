module NotificationsHelper
  # 通知を確認したらcheckedをtrueにするヘルパーメソッド
  def notification_checkded
    @notifications.each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def unchecked_notifications
    current_user.passive_notifications.where(checked: false)
  end
end
