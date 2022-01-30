class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  paginates_per 10

# Scopes para fazer pesquisas no BD
scope :_search_, ->(page, term){
                        includes(:answers, :subject)
                       .where("lower(description) LIKE ?", "%#{term.downcase}%")
                       .page(page)
}

scope :last_questions, ->(params){
                                includes(:answers, :subject).order('created_at desc')
                               .page(params[:page])
}

scope :_search_subject_, ->(page, subject_id){
  includes(:answers, :subject)
 .where(subject_id: subject_id)
 .page(page)
}
end
