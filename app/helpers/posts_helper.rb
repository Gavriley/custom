module PostsHelper

  def sorted_fields post
    sorted = []

    form_for post do |f|
      post.custom_fields.each do |field|

        child_index = rand(100001...999999)

        f.fields_for :custom_fields, field, child_index: child_index do |f|
          case field.kind
          when 'desc'
            block = f.label 'Description'
            block += f.text_area :value, class: 'form-control'
            block += f.hidden_field :id
            block += f.hidden_field :kind
            block += f.hidden_field :order, id: 'order'
          when 'role'
            label = f.label 'Roles'
            value = text_field_tag :role_value, nil, class: 'form-control'
            button = f.submit 'Add role', class: 'btn btn-success', id: 'add_role', url: create_role_posts_path

            block = label + content_tag(:div, content_tag(:div, value, class: 'col-sm-8') + content_tag(:div, button, class: 'col-sm-4'), class: 'row')

            role_block = ''

            f.object.children.each do |child|
              f.fields_for :children, child, child_index: rand(100001...999999) do |f|
                child_block = link_to 'X', nil, id: 'destroy_role'
                child_block += content_tag(:h4, f.object.value)
                child_block += f.hidden_field :id
                child_block += f.hidden_field :kind
                child_block += f.hidden_field :value
                child_block += f.hidden_field :order, id: 'role_order'
                child_block += f.hidden_field :_destroy, id: :_destroy
                role_block += content_tag(:div, child_block, class: 'role-item')
              end
            end

            block += content_tag(:div, role_block.html_safe, id: :sort_roles)
            block += hidden_field_tag :_role_index, child_index
            block += f.hidden_field :id
            block += f.hidden_field :kind
            block += f.hidden_field :order, id: 'order'
          when 'link'
            block = f.label 'Link'
            block += f.text_field :value, class: 'form-control'
            block += f.hidden_field :id
            block += f.hidden_field :kind
            block += f.hidden_field :order, id: 'order'
          when 'custom'
            name = f.label :name
            name += f.text_field :name, class: 'form-control'

            value = f.label :value
            value += f.text_field :value, class: 'form-control'

            block = content_tag(:div, content_tag(:div, name, class: 'col-sm-6') + content_tag(:div, value, class: 'col-sm-6'), class: 'row')
            block += link_to 'Delete', nil, id: 'destroy_field'
            block += f.hidden_field :_destroy, id: :_destroy
            block += f.hidden_field :id
            block += f.hidden_field :order, id: 'order'
          end

          sorted << block unless block.nil?
        end
      end
    end

    sorted
  end

  def new_custom_field
    block = ''

    form_for Post.new do |f|

      f.fields_for :custom_fields, f.object.custom_fields.build, child_index: rand(100001...999999) do |f|
        name = f.label :name
        name += f.text_field :name, class: 'form-control'

        value = f.label :value
        value += f.text_field :value, class: 'form-control'

        block = content_tag(:div, content_tag(:div, name, class: 'col-sm-6') + content_tag(:div, value, class: 'col-sm-6'), class: 'row')
        block += link_to 'Delete', nil, id: 'destroy_field'
        block += f.hidden_field :order, id: 'order'
      end
    end

    content_tag :div, block, class: 'form-group'
  end

  def create_role value, index
    block = ''

    form_for Post.new do |f|
      f.fields_for :custom_fields, f.object.custom_fields.build, child_index: index do |f|
        f.fields_for :children, f.object.children.build, child_index: rand(100001...999999) do |f|
          f.object.value = value
          block += link_to 'X', nil, id: 'destroy_role'
          block += content_tag(:h4, value)
          block += f.hidden_field :kind
          block += f.hidden_field :value
          block += f.hidden_field :order, id: 'role_order'
        end
      end
    end

    content_tag(:div, block.html_safe, class: 'role-item')
  end

end
