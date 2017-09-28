module CommentsHelper
	def tree_of_comments(comments)
		if comments
		  comments.map do |comment|
			render(comment) +
			  (comment.nested_comments.length > 0 ? content_tag(:div, tree_of_comments(comment.nested_comments),
			    class: "identation") : nil)
				end.join.html_safe
		else
	  		render("Not comments")
		end
	end
end
