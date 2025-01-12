class EsTest < ApplicationRecord
    has_secure_password
    has_many :user_password_changed_events
  
    def change_password(new_password)
      puts "new_password: #{new_password}"
      return false unless new_password.present? && new_password.length >= 6

      ActiveRecord::Base.transaction do
        # 現在のパスワードダイジェストを保存
        old_digest = password_digest
        #old_digest = password
        #old_digest = self.password
        
        # パスワードを更新
        #self.password = new_password
        #password = new_password
        self.password = new_password
        
        if save
            # イベントを記録
            user_password_changed_events.create!(
                old_password_digest: old_digest,
                #new_password_digest: password_digest,
                new_password_digest: new_password,
                changed_at: Time.current
            )
          true
        else
          false
        end
      end
=begin
      #return false unless valid?
      return false if new_password.blank?
          
      #old_password_digest = password_digest
      #old_password_digest = password
      #old_password_digest = self.password_digest
      old_password_digest = self.password

      # パスワードを更新
      #self.password = new_password
      password = new_password
      
      if save
        # イベントを記録
        user_password_changed_events.create!(
          old_password_digest: old_password_digest,
          #new_password_digest: password_digest,
          new_password_digest: new_password,
          changed_at: Time.current
        )
        true
      else
        false
      end
=end
    end

  # パスワード変更履歴を取得
  def password_change_history
    user_password_changed_events.order(changed_at: :desc)
  end
end