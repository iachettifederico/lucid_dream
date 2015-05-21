class JournalPresenter < Mystique::Presenter
  def path
    "/#{target.class.to_s.split("::").last.downcase}/#{slug}"
  end

  def link
    context.inspect
    h.link(name, path)
   end
end
