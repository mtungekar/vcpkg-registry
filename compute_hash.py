import hashlib
import os
import sys
from pathlib import Path,PurePath

class GitBlobHash:
    def __init__(self, filePath) -> None:
        self.file = Path(filePath)
        self.size = 0

    def hash(self):
        data = self.file.read_text()
        self.size = len(data)
        hashBlob = f"blob {self.size}\0".encode() + data.encode()
        self.digest = hashlib.sha1(hashBlob).hexdigest()
        return self.digest
    
#tree <size-of-tree-in-bytes>\0
#<file-1-mode> <file-1-path>\0<file-1-blob-hash>
#<file-2-mode> <file-2-path>\0<file-2-blob-hash>
#tree <size-of-tree-in-bytes>\0
#<file-1-mode> <file-1-path>\0<file-1-blob-hash>
#<file-2-mode> <file-2-path>\0<file-2-blob-hash>

class GitTreeHash:
    def __init__(self, directory) -> None:
        self.folder = Path(directory)
        self.treeData = []
        self.size = 0

    def hash(self):
        for p in self.folder.iterdir():
            if p.is_file():
                # file mode 100644
                blob = GitBlobHash(str(p))
                blobHash = blob.hash()
                data = f"100644 {str(p)}\0{blobHash}".encode()
                self.size += blob.size
                print(data)
                self.treeData.append(data)
            elif p.is_dir():
                # file modee 040000
                blob = GitTreeHash(str(p))
                blobHash = blob.hash()
                self.size += blob.size
                data = f"040000 {str(p)}\0{blobHash}".encode()
                print(data)
                self.treeData.append(data)
        hashBlob = f'tree {self.size}\0'.encode()+''.join(self.treeData)
        self.digest = hashlib.sha1(hashBlob)
        return self.digest
    

gitTree = Path(__file__).parent/"ports"
hasher = GitTreeHash(gitTree)
diget = hasher.hash()
print(diget)
