//
//  RemotelyLoadedImageView.swift
//  StampJourney
//
//  Created by Chris Petrou on 13/5/21.
//

import SwiftUI

/// Remotely loads an image from a url.
struct RemotelyLoadedImageView: View {
    private enum LoadState {
        case loading, success, failure
    }

    /// Loads the image and sets its state.
    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                print("Invalid URL: \(url)")
                return
            }

            URLSession.shared.dataTask(with: parsedURL) { data, _, _ in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    @State private var showingSheet = false
    @State private var shownImage: Data?

    var body: some View {
        HStack {
            selectImage()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
        }
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            MagnifiedImageView {
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                    //                    Color.clear
                    selectImage()
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .onTapGesture {
                            showingSheet.toggle()
                        }
                    Button(action: { showingSheet.toggle() }, label: {
                        Image(systemName: "xmark.circle.fill")
                    })
                    .offset(x: 5, y: 5)
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }

    /// The parameters for the view.
    /// - Parameters:
    ///   - url: The url for the image to be loaded.
    ///   - loading: Image to be shown for the loading state (optional).
    ///   - failure: Image to be shown for the failure state (optional).
    init(
        url: String,
        loading: Image = Image(systemName: "photo"),
        failure: Image = Image(systemName: "multiply.circle")
    ) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    /// Checks and returns the remote image if no errors.
    /// - Returns: Returns the remote image, or returns one of the icons depending on its state.
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = NSImage(data: loader.data) {

                return Image(nsImage: image)
            } else {
                return failure
            }
        }
    }
}

/// A view container for enlarging the image.
struct MagnifiedImageView<Content: View>: View {
    let content: Content

    var body: some View {
        content
    }

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
}
