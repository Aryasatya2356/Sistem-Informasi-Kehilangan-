import 'barang.dart';

class TreeNode {
  Barang data;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.data);
}

class SearchTree {
  TreeNode? root;

  void insert(Barang barang) {
    root = _insertRec(root, barang);
  }

  TreeNode _insertRec(TreeNode? node, Barang barang) {
    if (node == null) return TreeNode(barang);
    if (barang.nama.compareTo(node.data.nama) < 0) {
      node.left = _insertRec(node.left, barang);
    } else {
      node.right = _insertRec(node.right, barang);
    }
    return node;
  }

  Barang? search(String nama) {
    return _searchRec(root, nama);
  }

  Barang? _searchRec(TreeNode? node, String nama) {
    if (node == null) return null;
    if (node.data.nama == nama) return node.data;
    if (nama.compareTo(node.data.nama) < 0) {
      return _searchRec(node.left, nama);
    } else {
      return _searchRec(node.right, nama);
    }
  }

//-- method penghapusan --
  void delete(String nama) {
    root = _deleteRec(root, nama);
  }

  TreeNode? _deleteRec(TreeNode? node, String nama) {
    if (node == null) return null;

    if (nama.compareTo(node.data.nama) < 0) {
      node.left = _deleteRec(node.left, nama);
    } else if (nama.compareTo(node.data.nama) > 0) {
      node.right = _deleteRec(node.right, nama);
    } else {
      // Node ditemukan
      if (node.left == null) return node.right;
      if (node.right == null) return node.left;

      // Node dengan dua anak: cari inorder successor (terkecil di subtree kanan)
      TreeNode minNode = _findMin(node.right!);
      node.data = minNode.data;
      node.right = _deleteRec(node.right, minNode.data.nama);
    }

    return node;
  }

  TreeNode _findMin(TreeNode node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node;
  }
}
