module ApplicationHelper

    # Generic function: Hides the HTML <b>div</b> tag when the condition is true.
    #
    # ==PARAMETERS
    # * condition -> what to test
    # * the attributes - <i>optional</i> - are over ruled when the condition is true!
    # * the HTML block within the div
    def hidden_div_if(condition, attributes = (), &block)
        if condition
            attributes["style"] = "display: none"
        end
        content_tag("div", attributes, &block)
    end

    def is_admin?(user)
        admin_role = ROLES.find(:first, :conditions => ["name = ?", "admin"])
        return user.roles.include?(admin_role)
    end
end
