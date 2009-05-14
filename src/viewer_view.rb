import java.net.URL
import javax.swing.ImageIcon
import javax.swing.tree.DefaultMutableTreeNode

class ViewerView < Monkeybars::View
  set_java_class 'com.flickr.FlickrForm'

  map :view => 'search_field.text', :model => :search_terms
  map :view => 'photos_tree.model', :model => :search_results, :using => [:build_tree_nodes, nil]
  map :view => 'photos_tree.model.root.user_object', :model => :search_terms, :using => [:default, nil]
  
  def build_tree_nodes(search_results)
    root = DefaultMutableTreeNode.new('root', true)
    search_results.each do |photo|
      root.add DefaultMutableTreeNode.new(photo, true)
    end
    javax.swing.tree.DefaultTreeModel.new(root, true)
  end

  define_signal :expand_node, :expand_node
  def expand_node(model, transfer)
    expanding_node = transfer[:expanding_node]
    transfer[:photo_sizes].each do |size|
      expanding_node.add DefaultMutableTreeNode.new(size, false)
    end
  end
  
  define_signal :update_image, :update_image
  def update_image(model, transfer)
    image_label.icon = repaint_while{ImageIcon.new(URL.new(transfer[:image_url]))}
  end
end