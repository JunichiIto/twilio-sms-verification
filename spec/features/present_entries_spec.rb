# coding: utf-8
require 'spec_helper'

describe 'PresentEntries' do
  context 'when valid code' do
    it 'sets to be verified' do
      visit root_path
      fill_in '名前', with: '伊藤ひろふみ'
      fill_in '住所', with: '兵庫県西脇市'
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in '携帯電話番号', with: '090-1234-5678'
      click_button '次に進む'
      expect(page).to have_content '認証コードの入力'

      verification_code = PresentEntry.last.verification_code
      fill_in '認証コード', with: verification_code
      click_button '送信する'
      expect(page).to have_content 'プレゼント申込みを作成しました。'
    end
  end
  context 'when valid code' do
    it 'sets to be verified' do
      visit root_path
      fill_in '名前', with: '伊藤ひろふみ'
      fill_in '住所', with: '兵庫県西脇市'
      fill_in 'メールアドレス', with: 'hoge@hoge.com'
      fill_in '携帯電話番号', with: '090-1234-5678'
      click_button '次に進む'
      expect(page).to have_content '認証コードの入力'

      fill_in '認証コード', with: "123456"
      click_button '送信する'
      expect(page).to have_content '入力値に誤りがあります。'
    end
  end
end
